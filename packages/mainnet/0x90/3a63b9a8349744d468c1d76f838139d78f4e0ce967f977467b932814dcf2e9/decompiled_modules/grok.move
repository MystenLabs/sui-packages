module 0x903a63b9a8349744d468c1d76f838139d78f4e0ce967f977467b932814dcf2e9::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 9, b"GROK", b"GROK 3", b"The smartest AI on Earth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdYf9czkbrSzVKrnSrAhmf2CnTPnx95JJGD9yXwYL2vWk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

