module 0x3e77666c70c5da928c1845b2d0e5fb225180e92a264222946a000459ba784a43::dta {
    struct DTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTA>(arg0, 6, b"DTA", b"Dog Theft Auto on Sui", b"Welcome to the wildest coin on the blockchain. Join the pack, hit big, and lets change the game together | https://dogcoinautotheft.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rectangle_2_46d99e693d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

