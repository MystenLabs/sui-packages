module 0xa070af76ea692005238da3e9b0de80916cbce3a975295ab055c88eb7c5421157::coffee {
    struct COFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEE>(arg0, 6, b"Coffee", b"Sui Coffee", x"466972737420436f66666565206f6e20537569210a0a2d2032356b203a20302e323525206275726e65640a2d2035306b203a20302e3525206275726e65640a2d203130306b203a20302e3525206275726e65640a2d203135306b203a205442410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Coffee_60d8f13770.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFFEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

