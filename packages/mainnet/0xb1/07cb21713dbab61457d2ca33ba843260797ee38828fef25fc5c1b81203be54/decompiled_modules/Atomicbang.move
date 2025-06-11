module 0xb107cb21713dbab61457d2ca33ba843260797ee38828fef25fc5c1b81203be54::Atomicbang {
    struct ATOMICBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMICBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATOMICBANG>(arg0, 9, b"Bang", b"Atomicbang", b"atomic boom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8fa68232-6331-4803-b560-3f38866a3eae.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATOMICBANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATOMICBANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

