module 0xbb9211dc45e42e3cff3fd23f09a8c8c06879160b80c19f6fc80ede848556735e::dori {
    struct DORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORI>(arg0, 6, b"DORI", b"Dori on Sui", b"Lost and always exploring, DORI is here to dive deep into the Sui waters. Full of curiosity and a little mischief, this little fish has a big adventure ahead!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/indir_2f8e77a5fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

