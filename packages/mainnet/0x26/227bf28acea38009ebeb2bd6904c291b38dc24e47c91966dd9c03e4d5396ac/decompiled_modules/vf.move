module 0x26227bf28acea38009ebeb2bd6904c291b38dc24e47c91966dd9c03e4d5396ac::vf {
    struct VF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VF>(arg0, 9, b"VF", b"Verified", x"2a566572696669656420436f696e20285646292a0a0a41207365637572652c20646563656e7472616c697a65642c20616e64207472616e73706172656e742063727970746f63757272656e637920656d706f776572696e672066696e616e6369616c2066726565646f6d20616e642074727573742e0a0a0a2a5461676c696e653a2a2022547275737420566572696669656422", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e6587a5-9f82-4b95-a7c8-aee6c94596dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VF>>(v1);
    }

    // decompiled from Move bytecode v6
}

