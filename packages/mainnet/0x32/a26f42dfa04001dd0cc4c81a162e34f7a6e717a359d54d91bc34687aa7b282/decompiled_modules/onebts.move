module 0x32a26f42dfa04001dd0cc4c81a162e34f7a6e717a359d54d91bc34687aa7b282::onebts {
    struct ONEBTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEBTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<ONEBTS>(arg0, 6, b"ONEBTS", b"BTS Army of One", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRhoEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERGCQNLm71/qzUxxiOh/ZADQ/D1WUDgg3AMAADAYAJ0BKoAAgAA+bTSWR6QjIiEkk5tYgA2JaQAW16yD+Z/jB5u+Gvxp7MZwr63fZvyv5Adpj++flblrn0j/b9+FqBXkX+c49GZf/TP956X3/B/bvOV9I/933B/45/UP+N14v3D9mb9qjQs0LjSILNC40iBe5BKhk8AnQXZOlxaZQ4zFfzMoPyzAOw6IpegHA00mFBuVbhvoXuFSOngGXWchiewPVLcUcdI+QY1ZF7rp3f/oEXJqx7QEFiHz6NLoLeD9upILNC40VAAA/bP//OAhRFf//NwADj/r3jy5279gxBTAXV4vbFMG7GxNcAJR/E6mwFJCq+vv3LTDMXpJQyo0p+6qnzncZdkPe2J3oo3o5lRvrHZ/tHJz5mHvoN9ZG4ZZr7XEK1tgJvCAQcEOzD5vrHys79ZkUqeweL2kT+/D7lDHBihkakrhW8hu/05+6riBmq6wZ3Q013IxXZ7ErLO9LyA8pB/+mtu3AkDE67gRiizlvAvCqc6LSqQJ6ZRgadzrXXEsH4gbqPk5okVEf+AN/u/VR3Kn8GV5g9ZFFR1o/NgR4aO/Qm2Idw0VYDUVNrGzfyp1gwWG6FgcmqPk0BwRlIZs4Au+Fs3uaTFhU481W0vAR888CNFjZiiq5DZMdsukIdaHK/vwlDRJmelZwd+HujuBH/2mhGlJlHlV91CEUp8rppfQEi2e/emHSUBCb/AaP44MgROloyL/cePrJWSK2VTd2ZL/LykvG4xtyrNzpt/ErBoPThvdMePmM6iD/s8kBWhac9lNfm/NF0kseP9+3UD/Sbp9GEG5b6MSWe+D33K1dywjOMA2pg8twnwQA+t5CDN+5FP+99h2ne487T/Wic0re1PJUB4AVn3RS4b+fE6iBBk0kJ/hX+lPBg3oMnOYqkc0/ZRDLczbpmH9FqIInx7K0eocbk3EUpcg/8DL2byKncsiTS/4DTY99GgDAEfbMlARDLloeZG7jck4SiP/Ps+eezhZ7bfYpTLLr3gRCQY2aQrp1hFKgO2HvWvlhuNcDXbFaHUb1mk767wbQF3WUqmax0mkdA3n8K2pop+kD/2MdFUC50nf0HX+Mb6pdnCiuwbe3KaRKYkPbybh31fjVqMLejbn6p7Suw9ls+iHf4PN+/9ZxlJCWEUgNSXgtlw3w/TjN35Tzi/4bALwnhe/ioIn7ddzKzvRVTMdT+mUZcUXp1HVDt/K/GxS3mPQGPTIBbNR/uH8FuSF64Qurf3VWUGWRL+tNOYrxPH521YA/QGinQTsw5Gip2D+P0TcMdBV/PFRomVkYNkNwsAH+3jyHU91qmMYQAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEBTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEBTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

