module 0x19230397d3e8441ce5a565dfef6a9957d68776e8f6833f97cb1bec6d018ec4b1::bett {
    struct BETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETT>(arg0, 6, b"BETT", b"BLUBBETT", b"We decided BLUB needs a  woman, but which one should he choose? Lots of fish in the sea! But now the lab has over 1 Billion BLUB tokens to airdrop. NFTS will follow on Tradeport to those who hold for launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imageonline_co_gifimage_2024_10_01_T151235_662_b35972b5c4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

