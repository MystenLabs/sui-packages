module 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::price_mood {
    struct PRICE_MOOD has drop {
        dummy_field: bool,
    }

    struct PriceMoodWitness has store, key {
        id: 0x2::object::UID,
    }

    struct BoardOwnerCap has store, key {
        id: 0x2::object::UID,
        board_id: 0x2::object::ID,
    }

    struct MoodBoard has key {
        id: 0x2::object::UID,
        version: u64,
        witness_id: 0x2::object::ID,
        witness: 0x2::bag::Bag,
        pairs: u64,
    }

    struct PairMood has store, key {
        id: 0x2::object::UID,
        pair: 0x1::string::String,
        base: 0x1::string::String,
        quote: 0x1::string::String,
        face: 0x1::string::String,
        emoji: 0x1::string::String,
        label: 0x1::string::String,
        price: 0x1::string::String,
        price_scaled: u64,
        updated_ms: u64,
        readings: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (MoodBoard, BoardOwnerCap) {
        let v0 = PriceMoodWitness{id: 0x2::object::new(arg0)};
        let v1 = 0x2::bag::new(arg0);
        0x2::bag::add<vector<u8>, PriceMoodWitness>(&mut v1, b"witness", v0);
        let v2 = MoodBoard{
            id         : 0x2::object::new(arg0),
            version    : 1,
            witness_id : 0x2::object::id<PriceMoodWitness>(&v0),
            witness    : v1,
            pairs      : 0,
        };
        let v3 = BoardOwnerCap{
            id       : 0x2::object::new(arg0),
            board_id : 0x2::object::id<MoodBoard>(&v2),
        };
        (v2, v3)
    }

    fun input_commitment(arg0: &MoodBoard, arg1: &0x2::clock::Clock, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String) : vector<u8> {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(0x2::object::id<MoodBoard>(arg0));
        let v1 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(0x2::object::id<0x2::clock::Clock>(arg1));
        let v2 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(json_string(*0x1::string::as_bytes(arg2)));
        let v3 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(json_string(*0x1::string::as_bytes(arg3)));
        let v4 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(json_string(*0x1::string::as_bytes(arg4)));
        let v5 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v0));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v1));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v2));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v3));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v4));
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::input_hash(vector[b"0", b"1", b"2", b"3", b"4"], v5)
    }

    public fun label(arg0: &PairMood) : 0x1::string::String {
        arg0.label
    }

    fun add_pair(arg0: &mut MoodBoard, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::neutral();
        let v1 = PairMood{
            id           : 0x2::object::new(arg7),
            pair         : arg1,
            base         : arg2,
            quote        : arg3,
            face         : 0x1::string::utf8(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::codepoint(v0)),
            emoji        : 0x1::string::utf8(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::emoji(v0)),
            label        : 0x1::string::utf8(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::label(v0)),
            price        : arg4,
            price_scaled : arg5,
            updated_ms   : arg6,
            readings     : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, PairMood>(&mut arg0.id, arg1, v1);
        arg0.pairs = arg0.pairs + 1;
    }

    fun assert_owner(arg0: &BoardOwnerCap, arg1: &MoodBoard) {
        assert!(arg0.board_id == 0x2::object::id<MoodBoard>(arg1), 13906835419884552203);
        assert!(arg1.version == 1, 13906835424179388425);
    }

    fun assert_workflow_invocation(arg0: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult) {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::proof(arg0);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::type_name(v0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>()), 13906835389819125761);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(v0) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::execution_id(arg1), 13906835398409191427);
        assert!(!0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::is_finalized(arg1), 13906835402704289797);
    }

    public fun board_id(arg0: &BoardOwnerCap) : 0x2::object::ID {
        arg0.board_id
    }

    fun err(arg0: vector<u8>) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"err"), b"reason", text(arg0))
    }

    public fun execute(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg2: &mut MoodBoard, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert_workflow_invocation(&arg0, &arg1);
        assert!(input_commitment(arg2, arg3, &arg4, &arg5, &arg6) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::input_commitment(&arg1), 13906835084876840967);
        assert!(arg2.version == 1, 13906835093466906633);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::satisfy(&mut arg0, &witness(arg2).id);
        let v0 = parse_reading(&arg6);
        let v1 = if (!is_pair(&arg4, &arg5)) {
            err(b"pair symbols must be 1 to 10 uppercase letters or digits")
        } else if (v0 == 0) {
            err(b"price must be a positive decimal of at most 32 characters")
        } else {
            let v2 = 0x2::clock::timestamp_ms(arg3);
            let v3 = pair_name(&arg4, &arg5);
            if (!0x2::dynamic_object_field::exists<0x1::string::String>(&arg2.id, v3)) {
                add_pair(arg2, v3, arg4, arg5, arg6, v0, v2, arg7);
                let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PairMood>(&mut arg2.id, v3);
                first_reading(v4)
            } else {
                let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PairMood>(&mut arg2.id, v3);
                if (0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::accepts(v5.price_scaled, v5.updated_ms, v2, v0)) {
                    record(v5, arg6, v0, v2)
                } else {
                    err(b"price is more than 20% away from the last reading")
                }
            }
        };
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::finalize_and_share(arg1, arg0, v1, arg7);
    }

    public fun face(arg0: &PairMood) : 0x1::string::String {
        arg0.face
    }

    fun first_reading(arg0: &mut PairMood) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        arg0.readings = arg0.readings + 1;
        ok(arg0, 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::neutral(), false, 0)
    }

    public fun has_pair(arg0: &MoodBoard, arg1: 0x1::string::String) : bool {
        0x2::dynamic_object_field::exists<0x1::string::String>(&arg0.id, arg1)
    }

    fun hex_id(arg0: 0x2::object::ID) : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(0x2::object::id_to_address(&arg0))));
        v0
    }

    fun init(arg0: PRICE_MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PRICE_MOOD>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{emoji} {pair} Mood: {label}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Latest {base} price: {price} {quote}, meant to come from Coinbase via a Nexus workflow. Anyone can post readings, so this is not an oracle."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/72x72/{face}.png"));
        let v5 = 0x2::display::new_with_fields<PairMood>(&v0, v1, v3, arg1);
        0x2::display::update_version<PairMood>(&mut v5);
        let (v6, v7) = new(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PairMood>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<BoardOwnerCap>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MoodBoard>(v6);
    }

    fun is_pair(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::is_symbol(0x1::string::as_bytes(arg0)) && 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::is_symbol(0x1::string::as_bytes(arg1))
    }

    fun json_string(arg0: vector<u8>) : vector<u8> {
        let v0 = b"\"";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, 34);
        v0
    }

    fun number(arg0: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg0)))
    }

    fun ok(arg0: &PairMood, arg1: u8, arg2: bool, arg3: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        let v0 = if (arg3 == 0) {
            b"flat"
        } else if (arg2) {
            b"up"
        } else {
            b"down"
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"ok"), b"change_bps", number(arg3)), b"direction", text(v0)), b"emoji", text(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::emoji(arg1))), b"face", text(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::codepoint(arg1))), b"label", text(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::label(arg1))), b"mood_id", text(hex_id(0x2::object::id<PairMood>(arg0)))), b"pair", text(*0x1::string::as_bytes(&arg0.pair))), b"price", text(*0x1::string::as_bytes(&arg0.price)))
    }

    public fun pair(arg0: &PairMood) : 0x1::string::String {
        arg0.pair
    }

    public fun pair_mood(arg0: &MoodBoard, arg1: 0x1::string::String) : &PairMood {
        assert!(0x2::dynamic_object_field::exists<0x1::string::String>(&arg0.id, arg1), 13906836089899581453);
        0x2::dynamic_object_field::borrow<0x1::string::String, PairMood>(&arg0.id, arg1)
    }

    fun pair_name(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    public fun pairs(arg0: &MoodBoard) : u64 {
        arg0.pairs
    }

    fun parse_reading(arg0: &0x1::string::String) : u64 {
        if (0x1::string::length(arg0) > 32) {
            0
        } else {
            0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::parse_price(0x1::string::as_bytes(arg0))
        }
    }

    public fun price(arg0: &PairMood) : 0x1::string::String {
        arg0.price
    }

    public fun price_scaled(arg0: &PairMood) : u64 {
        arg0.price_scaled
    }

    public fun readings(arg0: &PairMood) : u64 {
        arg0.readings
    }

    fun record(arg0: &mut PairMood, arg1: 0x1::string::String, arg2: u64, arg3: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        let (v0, v1) = 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::change_bps(arg0.price_scaled, arg2);
        let v2 = 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::level(v0, v1);
        set_reading(arg0, v2, arg1, arg2, arg3);
        arg0.readings = arg0.readings + 1;
        ok(arg0, v2, v0, v1)
    }

    public fun remove_pair(arg0: &BoardOwnerCap, arg1: &mut MoodBoard, arg2: 0x1::string::String) {
        assert_owner(arg0, arg1);
        assert!(0x2::dynamic_object_field::exists<0x1::string::String>(&arg1.id, arg2), 13906835338280304653);
        let PairMood {
            id           : v0,
            pair         : _,
            base         : _,
            quote        : _,
            face         : _,
            emoji        : _,
            label        : _,
            price        : _,
            price_scaled : _,
            updated_ms   : _,
            readings     : _,
        } = 0x2::dynamic_object_field::remove<0x1::string::String, PairMood>(&mut arg1.id, arg2);
        0x2::object::delete(v0);
        arg1.pairs = arg1.pairs - 1;
    }

    public fun set_pair(arg0: &BoardOwnerCap, arg1: &mut MoodBoard, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert!(is_pair(&arg2, &arg3), 13906835273855926287);
        let v0 = parse_reading(&arg4);
        assert!(v0 != 0, 13906835282445991953);
        let v1 = pair_name(&arg2, &arg3);
        if (!0x2::dynamic_object_field::exists<0x1::string::String>(&arg1.id, v1)) {
            add_pair(arg1, v1, arg2, arg3, arg4, v0, 0x2::clock::timestamp_ms(arg5), arg6);
        } else {
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PairMood>(&mut arg1.id, v1);
            set_reading(v2, 0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::neutral(), arg4, v0, 0x2::clock::timestamp_ms(arg5));
        };
    }

    fun set_reading(arg0: &mut PairMood, arg1: u8, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        arg0.face = 0x1::string::utf8(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::codepoint(arg1));
        arg0.emoji = 0x1::string::utf8(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::emoji(arg1));
        arg0.label = 0x1::string::utf8(0x33a100d96e99a526026653779e6dd1304b9c66af870e72f38eb5893f6668af6e::mood::label(arg1));
        arg0.price = arg2;
        arg0.price_scaled = arg3;
        arg0.updated_ms = arg4;
    }

    fun text(arg0: vector<u8>) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(json_string(arg0))
    }

    public fun tool_witness_id(arg0: &MoodBoard) : 0x2::object::ID {
        arg0.witness_id
    }

    public fun updated_ms(arg0: &PairMood) : u64 {
        arg0.updated_ms
    }

    public fun version(arg0: &MoodBoard) : u64 {
        arg0.version
    }

    fun witness(arg0: &MoodBoard) : &PriceMoodWitness {
        0x2::bag::borrow<vector<u8>, PriceMoodWitness>(&arg0.witness, b"witness")
    }

    // decompiled from Move bytecode v7
}

