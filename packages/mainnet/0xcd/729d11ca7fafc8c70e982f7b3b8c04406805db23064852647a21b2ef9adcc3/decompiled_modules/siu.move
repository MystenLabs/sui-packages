module 0xcd729d11ca7fafc8c70e982f7b3b8c04406805db23064852647a21b2ef9adcc3::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 9, b"SIU", b"Siuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu", b"Coin for Cristiano Ronaldo Lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sharing.clickup.com/clip/p/t9012459255/2cbc48bc-59fc-4667-885d-cbc90aa396c9/screen-recording-2024-12-14-18%3A26.webm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIU>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

