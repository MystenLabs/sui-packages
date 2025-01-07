module 0x67076330eec45e538154188e95895a9bb528cd60e3814948be4b023496ac1a11::neggo {
    struct NEGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGGO>(arg0, 6, b"Neggo", b"suineggo", b"nemo but black", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9de26373874275b3d8de407b3ccb818_9bd6cce1d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

