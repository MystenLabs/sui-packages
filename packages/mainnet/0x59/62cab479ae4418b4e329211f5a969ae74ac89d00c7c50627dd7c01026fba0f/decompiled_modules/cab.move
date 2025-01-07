module 0x5962cab479ae4418b4e329211f5a969ae74ac89d00c7c50627dd7c01026fba0f::cab {
    struct CAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAB>(arg0, 9, b"CAB", b"Dubpcab ", b"Dubpcab is a meme that is for the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f62226ff-faa4-4604-974d-7a81ad40d310.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

