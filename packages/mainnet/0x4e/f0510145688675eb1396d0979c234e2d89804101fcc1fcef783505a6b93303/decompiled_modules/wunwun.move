module 0x4ef0510145688675eb1396d0979c234e2d89804101fcc1fcef783505a6b93303::wunwun {
    struct WUNWUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUNWUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUNWUN>(arg0, 6, b"WUNWUN", b"Wunwun the dog", b"This is Wunwun. The ultimate opet of SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728354922125_d561249f96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUNWUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUNWUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

