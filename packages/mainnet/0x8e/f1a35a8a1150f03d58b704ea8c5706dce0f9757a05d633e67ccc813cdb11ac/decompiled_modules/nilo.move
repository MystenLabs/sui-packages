module 0x8ef1a35a8a1150f03d58b704ea8c5706dce0f9757a05d633e67ccc813cdb11ac::nilo {
    struct NILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILO>(arg0, 6, b"Nilo", b"Niloo", b"Niloo is a female lovely dog in real world. She only able to Bark and sometimes When She feel dangour run away ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736061698879.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NILO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

