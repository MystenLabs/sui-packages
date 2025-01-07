module 0x38e8126e3e98f2c5242ab65267d066bb035a56eb942249049428ec435a4aa015::updog {
    struct UPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPDOG>(arg0, 6, b"UPDOG", b"UP DOG", x"205550444f47200a0a5550444f47206f6e6c7920676f657320555020646177672e205072696d656420666f72205570746f62657220616e642074686520656d657267696e672062756c6c2072756e2e204361747320616e6420686970706f7320636f6d6520616e6420676f2062757420446f6773206c6561642065766572792072756e2e0a0a68747470733a2f2f742e6d652f7570646f675f7375690a68747470733a2f2f782e636f6d2f7570646f675f737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UPDOG_59ba14adc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

