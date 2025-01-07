module 0x830721b382d13e157590fb06d93ceb4de19f8978bd7b6282155d022fd5620667::ashtar {
    struct ASHTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHTAR>(arg0, 6, b"ASHTAR", b"AshtarSheranGalacticCommander", b"Embodying the lore of the Galactic Federation, this token channels Ashtars cosmic mission to bring unity and higher consciousness to Earth. Created for those who resonate with the energies of light, wisdom, and interstellar peace, the Ashtar Sheran isnt just a memeit's a movement. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/quadro_ashtar_sheran_comandante_estelar_pleiadiano_pleidiano_32bf2159ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASHTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

