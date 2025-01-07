module 0xc95c26b30adcea3055fbd988c860416344ae229443d3f179bfc0de1ef59a9a5f::noil {
    struct NOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOIL>(arg0, 9, b"NOIL", b"No Impermanent Loss", b"lorem ipsum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/7f15ae69df37706565cecf67e9c93286blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

