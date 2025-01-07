module 0x2a0153372a3f67b9af831c412f5b08d831f0a9237a43282125c7f019e6a806c::we13145210 {
    struct WE13145210 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE13145210, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE13145210>(arg0, 9, b"WE13145210", b"wewe-", b"Handsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/496f3ee8-ee9d-4466-b619-d3ee629293db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE13145210>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE13145210>>(v1);
    }

    // decompiled from Move bytecode v6
}

