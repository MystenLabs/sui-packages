module 0xf74246b7655b45ef2a77967bb49c3d7c7f54aa535d648d8386ad3bcf653f4917::suisquirt {
    struct SUISQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISQUIRT>(arg0, 6, b"SUISQUIRT", b"Squirt on Sui", b"Deep in the heart of a bustling gas station on the edge of nowhere, a blue slushie churned endlessly in its machine, unassuming and vibrant. One day, a dagengerously erect traveler, irritated with the heat and the long line, leaned over the counter and let out an exasperated sigh, followed by an impulsive ejaculation that arced perfectly into the spinning vortex of icy blue. Little did they know, this tiny act of frustration would spark something extraordinary within the frosty concoction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049774_aaefbebf7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

