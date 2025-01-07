module 0xf0f4cec32db264f0dad79ff3e5845800be81e55dea3b37b8216ed2d3dcc5309e::jubs {
    struct JUBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUBS>(arg0, 6, b"JUBS", b"Stiv Jubs", b"Stiv Jubs, sporting a countenance bedecked with the unmistakable traits of his namesake, assumed the legendary black turtleneck and jeans, evoking the timeless style of the departed tech luminary.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_spaceship_2_c9c5ad53ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

