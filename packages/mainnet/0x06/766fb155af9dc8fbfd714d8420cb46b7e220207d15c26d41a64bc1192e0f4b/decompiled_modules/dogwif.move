module 0x6766fb155af9dc8fbfd714d8420cb46b7e220207d15c26d41a64bc1192e0f4b::dogwif {
    struct DOGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIF>(arg0, 9, b"DOGWIF", b"Dogewifsui", b"Dogewifsui is a fusion of Dogecoin's fun meme culture with Sui's high-speed, scalable blockchain technology. It brings the playful energy of Doge to the Sui network, offering fast, low-cost transactions and practical uses like tipping and gaming, while staying true to its lighthearted, community-driven roots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1392205620837822469/vp3-MxUV.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGWIF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

