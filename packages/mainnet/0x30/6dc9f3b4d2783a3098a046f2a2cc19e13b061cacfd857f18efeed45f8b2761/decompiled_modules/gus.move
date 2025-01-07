module 0x306dc9f3b4d2783a3098a046f2a2cc19e13b061cacfd857f18efeed45f8b2761::gus {
    struct GUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUS>(arg0, 6, b"GUS", b"Traveling Penguin", b"Waddle into a world of adventure with $GUS, the meme coin inspired by the legendary emperor penguin who dared to dream big and swim even bigger! Gus isn't just any penguin; has the fearless voyager who paddled over 2,000 miles from the icy Antarctic to the sun-kissed shores of Australia. Now, his spirit of resilience, curiosity, and unstoppable determination lives on in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ef9720a8_4126_4585_91c3_ff0a70d74ba3_9a917e9393.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

