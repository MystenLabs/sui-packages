module 0x5135446d26cb1f13b849f142af4aaf5382c8fe021e50d2c7df4ea2a2a1135dab::cranky {
    struct CRANKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRANKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRANKY>(arg0, 9, b"CRANKY", b"CrankyCat", b"A meme coin set to establish ground on the crypto market. Join now looking at 500x soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6afdca4a-9879-4391-8661-9b6f6e129ead.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRANKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRANKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

