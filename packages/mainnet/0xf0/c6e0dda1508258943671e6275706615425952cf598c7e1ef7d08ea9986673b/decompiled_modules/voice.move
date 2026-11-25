module 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::voice {
    struct Voice has key {
        id: 0x2::object::UID,
        canvas_id: 0x2::object::ID,
        owner: address,
        text: 0x1::string::String,
        note: 0x1::string::String,
        column: u16,
        row: u16,
        size: u8,
        cell_count: u64,
        gross_price_mist: u64,
        discount_mist: u64,
        sui_paid_mist: u64,
        spent_so: u64,
        voucher_id: 0x1::option::Option<address>,
        created_at_ms: u64,
        updated_at_ms: u64,
        revision: u64,
    }

    struct VoicePurchase {
        voice_id: 0x2::object::ID,
        canvas_id: 0x2::object::ID,
        buyer: address,
        expected_chunks: vector<ChunkTarget>,
        next_chunk_index: u64,
        processed_cell_count: u64,
        purchased_cell_count: u64,
        relinked_cell_count: u64,
        gross_total_mist: u128,
        total_refund_so: u128,
        max_total_mist: u64,
        so_authorization: 0x1::option::Option<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>,
    }

    struct ChunkTarget has copy, drop {
        chunk_x: u16,
        chunk_y: u16,
    }

    struct CellUpdated has copy, drop {
        x: u16,
        y: u16,
        previous_owner: 0x1::option::Option<address>,
        previous_voice_id: 0x1::option::Option<0x2::object::ID>,
        owner: address,
        voice_id: 0x2::object::ID,
        previous_price_mist: u64,
        price_mist: u64,
        gross_price_mist: u64,
        refund_so: u64,
        purchase_count: u64,
        ownership_changed: bool,
    }

    struct ChunkUpdated has copy, drop {
        canvas_id: 0x2::object::ID,
        voice_id: 0x2::object::ID,
        chunk_id: 0x2::object::ID,
        chunk_x: u16,
        chunk_y: u16,
        buyer: address,
        cells: vector<CellUpdated>,
    }

    struct VoiceCreated has copy, drop {
        voice_id: 0x2::object::ID,
        canvas_id: 0x2::object::ID,
        owner: address,
        text: 0x1::string::String,
        note: 0x1::string::String,
        column: u16,
        row: u16,
        size: u8,
        cell_count: u64,
        purchased_cell_count: u64,
        relinked_cell_count: u64,
        gross_price_mist: u64,
        discount_mist: u64,
        sui_paid_mist: u64,
        spent_so: u64,
        so_redemption: 0x1::option::Option<SORedemption>,
        total_refund_so: u64,
        created_at_ms: u64,
        revision: u64,
    }

    struct SORedemption has copy, drop {
        voucher_id: address,
        so_pass_id: 0x2::object::ID,
        nonce: u64,
        max_so: u64,
        signer_version: u64,
    }

    public fun apply_so_discount(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: &Voice, arg2: &mut VoicePurchase, arg3: &mut 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOPass, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, 0x2::clock::timestamp_ms(arg9));
        assert!(arg2.canvas_id == 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0), 4);
        assert!(arg2.voice_id == 0x2::object::id<Voice>(arg1), 4);
        assert!(arg2.buyer == 0x2::tx_context::sender(arg10), 5);
        assert!(arg1.canvas_id == arg2.canvas_id && arg1.owner == arg2.buyer, 4);
        assert!(0x1::option::is_none<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(&arg2.so_authorization), 12);
        assert!(arg2.next_chunk_index == 0, 13);
        0x1::option::fill<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(&mut arg2.so_authorization, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorize_voice_discount(arg0, arg3, arg2.buyer, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::voice_intent_hash(arg2.canvas_id, arg2.buyer, arg1.column, arg1.row, arg1.size, 0x1::string::as_bytes(&arg1.text), 0x1::string::as_bytes(&arg1.note), arg2.max_total_mist), arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun apply_voice_to_chunk(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: &mut 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Chunk, arg2: &Voice, arg3: &mut VoicePurchase, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, v0);
        assert!(arg3.canvas_id == 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0), 4);
        assert!(arg3.voice_id == 0x2::object::id<Voice>(arg2), 4);
        assert!(arg3.buyer == 0x2::tx_context::sender(arg5), 5);
        assert!(arg2.canvas_id == arg3.canvas_id && arg2.owner == arg3.buyer, 4);
        assert!(arg3.next_chunk_index < 0x1::vector::length<ChunkTarget>(&arg3.expected_chunks), 6);
        let v1 = 0x1::vector::borrow<ChunkTarget>(&arg3.expected_chunks, arg3.next_chunk_index);
        let v2 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::chunk_x_internal(arg1);
        let v3 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::chunk_y_internal(arg1);
        let v4 = if (0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::chunk_canvas_id_internal(arg1) == arg3.canvas_id) {
            if (v2 == v1.chunk_x) {
                v3 == v1.chunk_y
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 6);
        let v5 = arg3.voice_id;
        let v6 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::chunk_size_internal();
        let v7 = v2 * v6;
        let v8 = v3 * v6;
        let v9 = 0x1::vector::empty<CellUpdated>();
        let v10 = max_u16(arg2.row, v8);
        while (v10 < min_u16(arg2.row + (arg2.size as u16), v8 + v6)) {
            let v11 = max_u16(arg2.column, v7);
            while (v11 < min_u16(arg2.column + (0x1::string::length(&arg2.text) as u16) * (arg2.size as u16), v7 + v6)) {
                let v12 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::apply_cell_to_voice(arg0, arg1, arg3.buyer, v5, v11, v10, v0);
                let v13 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_ownership_changed(&v12);
                let v14 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_gross_price_mist(&v12);
                let v15 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_refund_so(&v12);
                arg3.processed_cell_count = arg3.processed_cell_count + 1;
                arg3.gross_total_mist = arg3.gross_total_mist + (v14 as u128);
                arg3.total_refund_so = arg3.total_refund_so + (v15 as u128);
                if (v13) {
                    arg3.purchased_cell_count = arg3.purchased_cell_count + 1;
                } else {
                    arg3.relinked_cell_count = arg3.relinked_cell_count + 1;
                };
                let v16 = CellUpdated{
                    x                   : v11,
                    y                   : v10,
                    previous_owner      : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_previous_owner(&v12),
                    previous_voice_id   : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_previous_voice_id(&v12),
                    owner               : arg3.buyer,
                    voice_id            : v5,
                    previous_price_mist : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_previous_price_mist(&v12),
                    price_mist          : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_price_mist(&v12),
                    gross_price_mist    : v14,
                    refund_so           : v15,
                    purchase_count      : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::application_purchase_count(&v12),
                    ownership_changed   : v13,
                };
                0x1::vector::push_back<CellUpdated>(&mut v9, v16);
                v11 = v11 + 1;
            };
            v10 = v10 + 1;
        };
        arg3.next_chunk_index = arg3.next_chunk_index + 1;
        let v17 = ChunkUpdated{
            canvas_id : arg3.canvas_id,
            voice_id  : v5,
            chunk_id  : 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Chunk>(arg1),
            chunk_x   : v2,
            chunk_y   : v3,
            buyer     : arg3.buyer,
            cells     : v9,
        };
        0x2::event::emit<ChunkUpdated>(v17);
    }

    fun assert_printable_ascii(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            assert!(v2 >= 32 && v2 <= 126, 0);
            v1 = v1 + 1;
        };
    }

    public fun begin_voice(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: u16, arg2: u16, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (Voice, VoicePurchase) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, v0);
        assert!(arg3 >= 1 && arg3 <= 3, 2);
        let v1 = 0x1::string::length(&arg4);
        assert!(v1 > 0 && v1 <= 80, 0);
        assert_printable_ascii(&arg4);
        assert!(0x1::string::length(&arg5) <= 140, 1);
        let v2 = 0x1::string::try_utf8(*0x1::string::as_bytes(&arg5));
        assert!(0x1::option::is_some<0x1::string::String>(&v2), 1);
        let v3 = (arg3 as u64);
        let v4 = v1 * v3;
        let v5 = (arg1 as u64) + v4;
        let v6 = (arg2 as u64) + v3;
        assert!(v5 <= (0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::width_cells(arg0) as u64) && v6 <= (0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::height_cells(arg0) as u64), 3);
        let v7 = 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0);
        let v8 = Voice{
            id               : 0x2::object::new(arg8),
            canvas_id        : v7,
            owner            : 0x2::tx_context::sender(arg8),
            text             : arg4,
            note             : arg5,
            column           : arg1,
            row              : arg2,
            size             : arg3,
            cell_count       : v4 * v3,
            gross_price_mist : 0,
            discount_mist    : 0,
            sui_paid_mist    : 0,
            spent_so         : 0,
            voucher_id       : 0x1::option::none<address>(),
            created_at_ms    : v0,
            updated_at_ms    : v0,
            revision         : 1,
        };
        let v9 = VoicePurchase{
            voice_id             : 0x2::object::id<Voice>(&v8),
            canvas_id            : v7,
            buyer                : 0x2::tx_context::sender(arg8),
            expected_chunks      : collect_chunk_targets(arg1, arg2, v5, v6),
            next_chunk_index     : 0,
            processed_cell_count : 0,
            purchased_cell_count : 0,
            relinked_cell_count  : 0,
            gross_total_mist     : 0,
            total_refund_so      : 0,
            max_total_mist       : arg6,
            so_authorization     : 0x1::option::none<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(),
        };
        (v8, v9)
    }

    fun calculate_discount(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: u64, arg2: &0x1::option::Option<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>) : (u64, u64) {
        if (0x1::option::is_none<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(arg2) || arg1 == 0) {
            return (0, 0)
        };
        calculate_discount_for_max_so(arg0, arg1, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorization_max_so(0x1::option::borrow<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(arg2)))
    }

    fun calculate_discount_for_max_so(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let v0 = (arg2 as u128);
        let v1 = (0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::so_per_sui_internal(arg0) as u128);
        let v2 = (arg1 as u128);
        let v3 = min_u128(v2, min_u128(v0 * 1000000000 / v1, v2 * (0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::max_so_discount_bps_internal(arg0) as u128) / 10000));
        let v4 = ceil_div(v3 * v1, 1000000000);
        assert!(v3 <= 18446744073709551615, 14);
        assert!(v4 <= v0 && v4 <= 18446744073709551615, 14);
        ((v3 as u64), (v4 as u64))
    }

    fun ceil_div(arg0: u128, arg1: u128) : u128 {
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    fun collect_chunk_targets(arg0: u16, arg1: u16, arg2: u64, arg3: u64) : vector<ChunkTarget> {
        let v0 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::chunk_size_internal();
        let v1 = 0x1::vector::empty<ChunkTarget>();
        let v2 = arg1 / v0;
        while (v2 <= ((arg3 - 1) as u16) / v0) {
            let v3 = arg0 / v0;
            while (v3 <= ((arg2 - 1) as u16) / v0) {
                let v4 = ChunkTarget{
                    chunk_x : v3,
                    chunk_y : v2,
                };
                0x1::vector::push_back<ChunkTarget>(&mut v1, v4);
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun consume_authorization(arg0: 0x1::option::Option<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>) : (0x1::option::Option<address>, 0x1::option::Option<SORedemption>) {
        if (0x1::option::is_some<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(&arg0)) {
            let v2 = 0x1::option::destroy_some<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(arg0);
            let v3 = 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorization_voucher_id(&v2);
            let v4 = SORedemption{
                voucher_id     : v3,
                so_pass_id     : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorization_pass_id(&v2),
                nonce          : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorization_nonce(&v2),
                max_so         : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorization_max_so(&v2),
                signer_version : 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::authorization_signer_version(&v2),
            };
            0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::destroy_authorization(v2);
            (0x1::option::some<address>(v3), 0x1::option::some<SORedemption>(v4))
        } else {
            0x1::option::destroy_none<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(arg0);
            (0x1::option::none<address>(), 0x1::option::none<SORedemption>())
        }
    }

    public fun create_pass_and_apply_so_discount(arg0: &mut 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: &Voice, arg2: &mut VoicePurchase, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, 0x2::clock::timestamp_ms(arg8));
        assert!(arg2.canvas_id == 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0), 4);
        assert!(arg2.voice_id == 0x2::object::id<Voice>(arg1), 4);
        assert!(arg2.buyer == 0x2::tx_context::sender(arg9), 5);
        assert!(arg1.canvas_id == arg2.canvas_id && arg1.owner == arg2.buyer, 4);
        assert!(0x1::option::is_none<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(&arg2.so_authorization), 12);
        assert!(arg2.next_chunk_index == 0, 13);
        0x1::option::fill<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::SOAuthorization>(&mut arg2.so_authorization, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::create_pass_and_authorize_voice_discount(arg0, arg2.buyer, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so::voice_intent_hash(arg2.canvas_id, arg2.buyer, arg1.column, arg1.row, arg1.size, 0x1::string::as_bytes(&arg1.text), 0x1::string::as_bytes(&arg1.note), arg2.max_total_mist), arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun finish_voice(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: Voice, arg2: VoicePurchase, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, 0x2::clock::timestamp_ms(arg4));
        assert!(arg2.canvas_id == 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0), 4);
        assert!(arg2.voice_id == 0x2::object::id<Voice>(&arg1), 4);
        assert!(arg2.buyer == 0x2::tx_context::sender(arg5), 5);
        assert!(arg1.canvas_id == arg2.canvas_id && arg1.owner == arg2.buyer, 4);
        assert!(arg2.next_chunk_index == 0x1::vector::length<ChunkTarget>(&arg2.expected_chunks), 7);
        assert!(arg2.processed_cell_count == arg1.cell_count, 8);
        assert!(arg2.purchased_cell_count + arg2.relinked_cell_count == arg1.cell_count, 8);
        assert!(arg2.gross_total_mist <= 18446744073709551615, 9);
        assert!(arg2.total_refund_so <= 18446744073709551615, 9);
        let v0 = (arg2.gross_total_mist as u64);
        assert!(v0 <= arg2.max_total_mist, 10);
        let (v1, v2) = calculate_discount(arg0, v0, &arg2.so_authorization);
        let v3 = v0 - v1;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v3, 11);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v3, arg5), 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::treasury(arg0));
        };
        let VoicePurchase {
            voice_id             : v4,
            canvas_id            : v5,
            buyer                : v6,
            expected_chunks      : _,
            next_chunk_index     : _,
            processed_cell_count : _,
            purchased_cell_count : v10,
            relinked_cell_count  : v11,
            gross_total_mist     : _,
            total_refund_so      : _,
            max_total_mist       : _,
            so_authorization     : v15,
        } = arg2;
        let (v16, v17) = consume_authorization(v15);
        arg1.gross_price_mist = v0;
        arg1.discount_mist = v1;
        arg1.sui_paid_mist = v3;
        arg1.spent_so = v2;
        arg1.voucher_id = v16;
        let v18 = VoiceCreated{
            voice_id             : v4,
            canvas_id            : v5,
            owner                : v6,
            text                 : arg1.text,
            note                 : arg1.note,
            column               : arg1.column,
            row                  : arg1.row,
            size                 : arg1.size,
            cell_count           : arg1.cell_count,
            purchased_cell_count : v10,
            relinked_cell_count  : v11,
            gross_price_mist     : v0,
            discount_mist        : v1,
            sui_paid_mist        : v3,
            spent_so             : v2,
            so_redemption        : v17,
            total_refund_so      : (arg2.total_refund_so as u64),
            created_at_ms        : arg1.created_at_ms,
            revision             : arg1.revision,
        };
        0x2::event::emit<VoiceCreated>(v18);
        0x2::transfer::transfer<Voice>(arg1, v6);
    }

    fun max_u16(arg0: u16, arg1: u16) : u16 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min_u16(arg0: u16, arg1: u16) : u16 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    // decompiled from Move bytecode v7
}

