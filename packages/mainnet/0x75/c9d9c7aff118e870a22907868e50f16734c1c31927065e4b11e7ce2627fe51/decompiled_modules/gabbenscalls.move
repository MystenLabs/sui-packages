module 0x75c9d9c7aff118e870a22907868e50f16734c1c31927065e4b11e7ce2627fe51::gabbenscalls {
    struct GABBENSCALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GABBENSCALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GABBENSCALLS>(arg0, 6, b"t.me/GabbensCalls", b"t.me/GabbensCalls", b"telegram: GabbensCalls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/1zxfgue.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GABBENSCALLS>>(v1);
        0x2::coin::mint_and_transfer<GABBENSCALLS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GABBENSCALLS>>(v2);
    }

    // decompiled from Move bytecode v6
}

