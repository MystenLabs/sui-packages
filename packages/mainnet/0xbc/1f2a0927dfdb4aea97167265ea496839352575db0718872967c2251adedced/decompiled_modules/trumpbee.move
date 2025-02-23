module 0xbc1f2a0927dfdb4aea97167265ea496839352575db0718872967c2251adedced::trumpbee {
    struct TRUMPBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBEE>(arg0, 6, b"TrumpBee", b"BEE TRUMP", b"Trump Bee is a meme that represents the diligence of President Donald Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/2e776501-6a8d-4729-a861-0bf5e571d1b6.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

