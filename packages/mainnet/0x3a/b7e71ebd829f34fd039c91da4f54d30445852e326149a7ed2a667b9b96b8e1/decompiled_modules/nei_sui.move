module 0x3ab7e71ebd829f34fd039c91da4f54d30445852e326149a7ed2a667b9b96b8e1::nei_sui {
    struct NEI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEI_SUI>(arg0, 9, b"NEI_SUI", b"NeiroSui", b"Neiro on sui is newly-adopted Shiba Inu dog, by the same woman who owned worldwide famous Kabosus, the doge behind the Doge meme. This project pays homage to Neiro..  as we know neiro on eth and sol both is hype.. let see on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a51f34d-f2b6-44dc-a7ea-741a27695336.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

