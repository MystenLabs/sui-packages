module 0x519d6dca1494ee20bc9a08a1f18550bcc0a94b2ee22dcac04837ebc46f569224::krypt {
    struct KRYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRYPT>(arg0, 6, b"Krypt", b"EnKrypto", b"Your favorite superhero's dog has been EnKrypted into the blockchain to help you ward off evil.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_B_Ff_J_o_400x400_1_556cc3c2a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRYPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRYPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

