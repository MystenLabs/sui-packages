module 0xd032d822066d5c513bc3472cc846827602c541e32d951c7de746185e3097542a::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 9, b"SUISUI", b"Sui Sui", b"Sui Sui is a legend on TikTok from faraway Eastern lands. Now, Sui Sui has come to take their rightful place as king kitty of the Sui jungle! Jeets fear him! Nocoiners tremble at the very mention of his name... Sui Sui is inevitable...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F08884dc90c364d76a6ca471dc70a7be0_1719327147_5094b4e23b.jpeg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISUI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

