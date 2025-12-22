module 0x5eab2e99a8fa5f8fa8f5d5ceb74c0c7a953d773dc11200a4dc4bec57ec0527e::ocr3_base {
    struct UnvalidatedPublicKey has copy, drop, store {
        bytes: vector<u8>,
    }

    struct ConfigInfo has copy, drop, store {
        config_digest: vector<u8>,
        big_f: u8,
        n: u8,
        is_signature_verification_enabled: bool,
    }

    struct OCRConfig has copy, drop, store {
        config_info: ConfigInfo,
        signers: vector<vector<u8>>,
        transmitters: vector<address>,
    }

    struct OCR3BaseState has store, key {
        id: 0x2::object::UID,
        ocr3_configs: 0x2::table::Table<u8, OCRConfig>,
        signer_oracles: 0x2::table::Table<u8, vector<UnvalidatedPublicKey>>,
        transmitter_oracles: 0x2::table::Table<u8, vector<address>>,
    }

    struct ConfigSet has copy, drop {
        ocr_plugin_type: u8,
        config_digest: vector<u8>,
        signers: vector<vector<u8>>,
        transmitters: vector<address>,
        big_f: u8,
    }

    struct Transmitted has copy, drop {
        ocr_plugin_type: u8,
        config_digest: vector<u8>,
        sequence_number: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : OCR3BaseState {
        OCR3BaseState{
            id                  : 0x2::object::new(arg0),
            ocr3_configs        : 0x2::table::new<u8, OCRConfig>(arg0),
            signer_oracles      : 0x2::table::new<u8, vector<UnvalidatedPublicKey>>(arg0),
            transmitter_oracles : 0x2::table::new<u8, vector<address>>(arg0),
        }
    }

    public fun ocr_plugin_type_commit() : u8 {
        0
    }

    public fun ocr_plugin_type_execution() : u8 {
        1
    }

    public fun set_ocr3_config(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: vector<vector<u8>>, arg4: vector<address>) {
        let v0 = ConfigSet{
            ocr_plugin_type : arg1,
            config_digest   : arg0,
            signers         : arg3,
            transmitters    : arg4,
            big_f           : arg2,
        };
        0x2::event::emit<ConfigSet>(v0);
    }

    // decompiled from Move bytecode v6
}

