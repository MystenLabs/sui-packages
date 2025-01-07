module 0x4e1ff55f3553864bf9ec8883f342a6d3db40bd1bf510c1e5f32f656a1edd4e7::shelby {
    struct SHELBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHELBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHELBY>(arg0, 6, b"SHELBY", b"PEPE SHELBY", b"\"Pepe Shelby\" is a memecoin inspired by the iconic fusion of Pepe the Frog and the stylish, tough persona of a vintage gangster, akin to the character Tommy Shelby from Peaky Blinders. The coin embodies a blend of rebellion, sharp wit, and community-driven growth, with a focus on elegance and influence within the meme space. Its mascot, \"Pepe Shelby,\" dons a sharp suit and flat cap, symbolizing both sophistication and streetwise cleverness, representing a crypto for those who embrace risk, power, and the ultimate meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/peakypepe_fed96849ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHELBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHELBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

