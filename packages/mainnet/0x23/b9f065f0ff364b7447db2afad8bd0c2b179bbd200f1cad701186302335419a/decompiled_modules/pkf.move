module 0x23b9f065f0ff364b7447db2afad8bd0c2b179bbd200f1cad701186302335419a::pkf {
    struct PKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKF>(arg0, 9, b"PKF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/746f73ea-b7ad-4c5e-bf1f-7bf70733c8e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

