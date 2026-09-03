module 0x81504f8acace4a81a1a84872a97de69e9b0a71c66eaeacd5c1de111bb8eb6883::sity {
    struct SITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_1501-XtjRl54fef1EpNuq9Nlj14QXM9DRD9.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_1501-XtjRl54fef1EpNuq9Nlj14QXM9DRD9.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SITY>(arg0, 9, b"SITY", b"SuiCity", x"5768657265207468652073747265657473206172652077696c642c20746865206d6f6e6579206e6576657220736c656570732c20616e642065766572796f6e652069732063686173696e6720746865206e657874206269672073636f72652e20f09f92b8f09f8c830a0a582068747470733a2f2f782e636f6d2f73756963697479746f6b656e0a54656c656772616d2068747470733a2f2f742e6d652f73756963697479746f6b656e0a576562736974652068747470733a2f2f737569636974792e66756e", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SITY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SITY>>(0x2::coin::mint<SITY>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

