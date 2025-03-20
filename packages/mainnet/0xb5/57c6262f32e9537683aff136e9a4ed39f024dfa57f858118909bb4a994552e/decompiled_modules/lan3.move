module 0xb557c6262f32e9537683aff136e9a4ed39f024dfa57f858118909bb4a994552e::lan3 {
    struct LAN3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN3>(arg0, 6, b"LAN3", b"LAN003", b"003", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7laP7RRhL8moDy2c4-EjzfK00LSBbgPwZcQ&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN3>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN3>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN3>>(v2);
    }

    // decompiled from Move bytecode v6
}

