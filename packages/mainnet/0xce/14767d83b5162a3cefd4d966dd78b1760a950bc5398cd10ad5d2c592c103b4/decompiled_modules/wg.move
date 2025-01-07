module 0xce14767d83b5162a3cefd4d966dd78b1760a950bc5398cd10ad5d2c592c103b4::wg {
    struct WG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WG>(arg0, 9, b"WG", b"WeweGumo", b"Wewe Gumo Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2348a8bc-76b7-4467-acac-a51bddfb58db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WG>>(v1);
    }

    // decompiled from Move bytecode v6
}

