module 0x5a9020b8cba51a1acbe16bee819d18d167ba29aa874116bf82d2ed79899edc7e::congratulationsyouwon1000suiclaimyourgainnowatwwwrafflesuicom {
    struct CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>, arg1: 0x2::coin::Coin<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>) {
        0x2::coin::burn<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>(arg0, arg1);
    }

    fun init(arg0: CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>(arg0, 9, b"congratulations! you won 1000 sui ! claim your gain now at: www.raffle-sui.com", b"won", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/3HWfG5Z.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>>(v1);
        0x2::coin::mint_and_transfer<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CONGRATULATIONSYOUWON1000SUICLAIMYOURGAINNOWATWWWRAFFLESUICOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

