module 0x20f0ecd241010a18908dbd91bd19ffa88eb6943b9237effeb40ecdbb70e42562::albert {
    struct ALBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALBERT>(arg0, 6, b"ALBERT", b"Albert II Duke of Austria", b"Albert II, Duke of Austria (1298-1358); member of the House of Habsburg and the Original Boys Club. Duke of Austria and Styria from 1330, as well as duke of Carinthia and margrave of Carniola from 1335. Known variously as \"the Wise\" (der Weise), \"the Lame\" (der Lahme), or \"the Big Fat Fucking Fuck\" (der Chungus). ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ALBERT_II_998e15e086.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALBERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

