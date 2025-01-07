module 0xc80b8671acaeeefbdc9927bb8aaa5b22ba99a2b8612f047b3cc38c01e567bc6f::suibmarine {
    struct SUIBMARINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBMARINE>(arg0, 6, b"SUIBMARINE", b"SUBMARINE OF THE MASSIVE SUI SEAS!", b"$SUIBMARINE is your vessel for navigating the uncharted waters of Sui. Gather your crew, dive deep, and explore the depths of Sui seas where untapped potential lies. Whether you're hunting for treasure or charting new paths, $SUIBMARINE is your ride to the hidden riches of the Sui seas. Ready to dive in?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBMARINE_ba2a5cf0d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBMARINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBMARINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

