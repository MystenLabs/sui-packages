module 0xda2aeb9f6c5b33055b5d6e4ffd17a8c3aa4cd539cbaa1dee1425b6e505898d42::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044a4f534509426c61737420446576754e6f772064656c6179206f6e636520616761696e202c206e6f7720616e6e6f756e6365206d6f72652066756e6374696f6e732c206e6f772064656c617920616761696e2c2065646765206c61756e63682c206d6f726520726f626f74732c206e6f772073756e736574207468652070726f6a6563744268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66383937346332353264336162653037313063646361633863613361636435342e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

