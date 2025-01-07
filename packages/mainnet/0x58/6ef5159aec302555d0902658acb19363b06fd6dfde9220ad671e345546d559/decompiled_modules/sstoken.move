module 0x586ef5159aec302555d0902658acb19363b06fd6dfde9220ad671e345546d559::sstoken {
    struct SSTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTOKEN>(arg0, 9, b"SSTOKEN", b"ShibaShark", b"Shiba Shark Token is a meme-based cryptocurrency combining the playful spirit of Shiba Inu with the boldness of a shark. It's built for fun, community, and moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b740f217-f8ad-4fa3-ac58-97173ea410a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

