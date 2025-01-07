module 0x4b048fdbba6b4d8b28cae9364ebe70cc0c5edcc6a64ccd611c58dd2685fcc346::kfk {
    struct KFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFK>(arg0, 6, b"KFK", b"Kung Fu Kangaroo", b"Kung Fu Kangaroo is the high-energy memecoin on Sui, bringing kung fu action and kangaroo vibes to the crypto world. With its playful spirit and unstoppable bounce, its all about fun and community. Join the dojo and leap into the excitement! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KFKPFP_e3aea12231.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

