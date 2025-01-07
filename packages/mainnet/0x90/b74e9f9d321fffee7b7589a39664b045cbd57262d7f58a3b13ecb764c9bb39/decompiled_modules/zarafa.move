module 0x90b74e9f9d321fffee7b7589a39664b045cbd57262d7f58a3b13ecb764c9bb39::zarafa {
    struct ZARAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARAFA>(arg0, 6, b"ZARAFA", b"SUI ZARAFA", b"$ZARAFA Where timeless elegance meets the future of crypto, standing tall in innovation and grace!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g89d_Vgcr_400x400_671801d2ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

