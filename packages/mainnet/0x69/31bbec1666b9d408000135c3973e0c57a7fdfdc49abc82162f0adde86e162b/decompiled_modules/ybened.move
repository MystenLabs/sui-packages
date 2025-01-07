module 0x6931bbec1666b9d408000135c3973e0c57a7fdfdc49abc82162f0adde86e162b::ybened {
    struct YBENED has drop {
        dummy_field: bool,
    }

    fun init(arg0: YBENED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YBENED>(arg0, 9, b"YBENED", b"Yben", b"Token food enjoying moment...good food brings happiness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63b92df5-51c9-4f0f-8ba3-40675527ceed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YBENED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YBENED>>(v1);
    }

    // decompiled from Move bytecode v6
}

