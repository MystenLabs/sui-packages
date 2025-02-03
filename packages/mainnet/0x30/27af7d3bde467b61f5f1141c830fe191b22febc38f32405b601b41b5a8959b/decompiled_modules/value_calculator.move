module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::value_calculator {
    public fun usd_value(arg0: 0x1::fixed_point32::FixedPoint32, arg1: u64, arg2: u8) : 0x1::fixed_point32::FixedPoint32 {
        0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::mul(arg0, 0x1::fixed_point32::create_from_rational(arg1, 0x2::math::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

