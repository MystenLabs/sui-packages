module 0x72cc0897dcca072c2e8bfd2f5bc0dc9ddd618b872ca0f924e45dc9b85af97f31::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 9, b"DINO", b"Dinoverse ", b"Embark on a prehistoric journey of wealth and adventure. Our token powers a thriving ecosystem of NFT dinosaurs, where you can collect, breed, and battle your way to the top. Join our community and become a legend in the Dinoverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7d6def8-354b-4548-a649-97c687cc1f1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

