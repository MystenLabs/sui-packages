module 0x8a4fd6f3464ce509709cc7b57d071fc283b15219a3e1ab9bd82e85746624ef13::tnk {
    struct TNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNK>(arg0, 9, b"TNK", b"Ngo Khong", x"54c3b46e204e67e1bb99204b68c3b46e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ac240bf-a76a-4c2d-a57b-3327b648528b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

