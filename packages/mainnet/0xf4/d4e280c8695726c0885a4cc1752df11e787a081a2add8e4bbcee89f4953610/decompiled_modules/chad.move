module 0xf4d4e280c8695726c0885a4cc1752df11e787a081a2add8e4bbcee89f4953610::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"GIGACHAD", b"Gigachad is a meme that has been around for years and is now a worldwide phenomenon. The meme is based on a photoshoot of Russian bodybuilder Ernest Khalimov, who was coined Gigachad for his perfect physique, jawline, and being a symbol of what a peak masculine male should strive for. $CHAD is a community-run cryptocurrency token built on the SUI blockchain. It is a token built exclusively for high testosterone individuals with a focus on self-improvement, masculinity, and becoming a true Gigachad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gigachad_logo_200x200_9af50b484a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

