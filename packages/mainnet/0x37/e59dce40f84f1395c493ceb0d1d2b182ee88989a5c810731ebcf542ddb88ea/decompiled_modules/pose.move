module 0x37e59dce40f84f1395c493ceb0d1d2b182ee88989a5c810731ebcf542ddb88ea::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSE>(arg0, 9, b"POSE", b"POSUIDON", b"I am a bold mermaid man unicorn who magically and majestically guards the SUI ocean from chaos and instability (scams and rug pulls).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/uc?export=download&id=1L8pYa1ZBPeVJ566Ym9pW-_8VQ4pqvWWs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POSE>(&mut v2, 3333333333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

