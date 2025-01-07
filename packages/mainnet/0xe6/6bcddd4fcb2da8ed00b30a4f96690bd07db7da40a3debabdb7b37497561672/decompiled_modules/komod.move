module 0xe66bcddd4fcb2da8ed00b30a4f96690bd07db7da40a3debabdb7b37497561672::komod {
    struct KOMOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMOD>(arg0, 6, b"KOMOD", b"KOMODO DRAGON", b"As a lazy Komodo dragon basking under the warm tropical sun, I began my day with a slow stroll along the sandy shore, leaving my tracks behind. For breakfast, I indulged in a few small lizards while enjoying the sight of birds fluttering around me. When the midday heat grew intense, I retreated to the cool shade of a tree, curling up on the soft sand for a restful break. Later, I wandered to a nearby waterhole, quenching my thirst and flicking my tongue to catch the scents in the air. In the late afternoon, I ventured into the depths of the forest, patiently hunting for prey, though it often tested my endurance. As the sun set, painting the sky in hues of orange and purple, I climbed atop a large rock, surveying my kingdom and feeling deeply connected to the magnificent cycle of nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/komod_de2b5dea9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

