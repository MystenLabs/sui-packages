module 0x3bcdd77595afcfe82e9e8d110892d77902bebd9acf31f6b1f8e5452ca61550c0::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554942554c4c085375692042756c6c9c015468652062756c6c2068617320656e7465726564205375692e0a43616c6d2e2048796472617465642e2042756c6c6973682e0a0a537569206973206a7573742067657474696e6720737461727465642e0a537461792048796472617465642e20537461792042756c6c6973682e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b7074395867486662513167784e446331227d6e68747470733a2f2f706c756d2d6c6567616c2d686164646f636b2d3939332e6d7970696e6174612e636c6f75642f697066732f62616679626569676b64786470346f7979736e6d6f663664657a79777968713473706d7366777265676667666c6e35717579743673357565686a69");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

