module 0x1fdb6793a09fd45c04146b1cf89b5a413a255c049136d35e2fab1aedb6dccd58::beno {
    struct BENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENO>(arg0, 2, b"BENO", b"Beno", b"Beno Token: The Fun Meme Coin  Lop Token is a vibrant and community-driven meme coin designed to bring joy and laughter to the crypto space. With a playful and engaging brand, Lop aims to create a lighthearted atmosphere while fostering a strong community of supporters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtjf0w_QE2ECsPlCRMtwxCCl5iYH8qeIzmnMODKu05W0-PcQiOxEyJ0z7NyeedOZP4kj4&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENO>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

