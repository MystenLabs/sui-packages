module 0xca86eab7dca5ef93b6245c8f018dc964607c3e625395f23986ac64663020116b::sele_sui {
    struct SELE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELE_SUI>(arg0, 9, b"seleSUI", b"Sele Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRhgCAABXRUJQVlA4IAwCAACQEgCdASqAAIAAPm02k0gkIzGrpJ47CjANiWcIcAGWHcAvgCyZAg2DnRnnHOpNs2zSLKUEr8XmpzIj/DOoCAVQUGjsv6alq9Px0zvz7Rjgo+j4T757FuVM2Y4s7HCDPOdZCbP/IQQu+LFJchZ+OokCD/5Age6KIBOkjTwEcl75eTZafBnIurMVusIMyrYIqMhqmHa/KSmxegUFiFfAAP55rHgy22Kj//IMf7sv9JOJvcY3oo6nVRHsdxGxWggng2AVlzKjwId/IGvWsCgXw5kuBisDC6/Hg42doeRE4l+xgKzbGu56yQ0KeXDjoVsQmAaNF3rcXQLCL+9w3z/BySZneu8u+EAfT7FYGPZ0m2BTt/4AsgjaV90pnMpGkB+x/xvBQc0TRjIgpzQ9octoTI6n/yFQBfzQZZ5PWsR62RbgrJnePUCzPoVbf7hss2O8O9a7h1a+TtRVEsWyOMrprJ8gInTo/gv2t5xoo/xzQQbHMMorvQgjfbOoCpeGsR9FgeNYViwhrGf39xUKPYVGKZ5GuFGxwt4RoS2LEI7OjfGy1/bzXKg+Eo/19yUQAQipxGG3Bmp47HqDejRXnLrQ3gpriNyspO2/8092abe2Z+2Xc+Di++EfVyuMXF/YiqVXm3/JjLL8+5QCfDt4iaTqTBPRVVMtNLnuvVe75LxDrdD1xJwr8T8TogkxAAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

