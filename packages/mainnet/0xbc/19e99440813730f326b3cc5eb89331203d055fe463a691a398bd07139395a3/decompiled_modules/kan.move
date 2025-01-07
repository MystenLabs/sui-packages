module 0xbc19e99440813730f326b3cc5eb89331203d055fe463a691a398bd07139395a3::kan {
    struct KAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAN>(arg0, 6, b"KAN", b"Crushing Kandi", b"Vibrant kandi-themed visuals. Each kandi piece, meticulously crafted to trigger your tastebuds. Jellybeans, gumdrops, striped or wrapped,. All with a distinct character to satisfy the many types of kandi enthusiasts out there. And there is more. Each distinct kandi has its own individual story.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Crush_Paint_2774b127c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

