module 0x9a4f1cf8aafd28f298f46676207fd03d8af815a5ca1505ee7269c74259eef027::vft {
    struct VFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFT>(arg0, 6, b"VFT", b"Vesse Food Tracker $VFT", b"BUY ONLU ON turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ik4i_Ui_Fx_400x400_19ef09b5ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

