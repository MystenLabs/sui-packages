module 0xe59f92fc5764b1fb20412daab8dff0ff9539244e6d487a52f3eba66b6c9334d7::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424c41535405424c415354c80143616c6c65642062792068747470733a2f2f782e636f6d2f4d6a626472616e2076696120404f7572626c617374626f7420224e6f7469636520677579732054686973206973206e6f74206d61696e20746f6b656e20666f722024426c617374205468697320776173207468652077617920746f2073686f7720796f7520686f77206974277320646f6e652c20616e64206f6e65206d6f7265207468696e672c2c207768656e20796f75206c61756e6368206f6e20626f7420404f7572626c617374626f742077616c2168747470733a2f2f6f7572626c6173742e78797a2f69636f6e2d3139322e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

