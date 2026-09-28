module 0x37a75a6115d6f33b2dd974025e23ac26e75fdbff10ff927bdcdd1f823b1874f6::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04574f4c4611576f6c66206f6620537569737472656574c301496e20746865206865617274206f66207468652053756920626c6f636b636861696e2c2061206e657720657261206f6620646563656e7472616c697a65642066696e616e6365206973206461776e696e672e20496e74726f647563696e6720576f6c664f665375697374726565742c2061207265766f6c7574696f6e6172792070726f6a6563742064657369676e656420746f20656d706f77657220696e766573746f727320616e642074726164657273206c696b65206e65766572206265666f72654268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f61306139326531623933303363323366323230363634396261363236346334392e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

