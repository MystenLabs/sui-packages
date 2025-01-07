module 0xe467b24a8e91b42e945f08e6799931b13f32bc43bba27d5a1e0c564cd50b341a::fwe {
    struct FWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWE>(arg0, 9, b"FWE", b"flower", b"Beautiful and loaded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3fadc0a-9061-42a9-be37-eb7058ae1e9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

