module 0x225e72993249cb2d7995e009a09cce545955d9738e4c741fb50463334fc31c71::curso {
    struct Cuadrado has copy, drop, store {
        lado: u64,
    }

    struct Rectangulo has copy, drop, store {
        base: u64,
        altura: u64,
    }

    struct Triangulo has copy, drop, store {
        base: u64,
        altura: u64,
    }

    struct Circulo has copy, drop, store {
        radio: u64,
    }

    public fun calcular_area_circulo(arg0: &Circulo) : u64 {
        314 * arg0.radio * arg0.radio / 100
    }

    public fun calcular_area_cuadrado(arg0: &Cuadrado) : u64 {
        arg0.lado * arg0.lado
    }

    public fun calcular_area_rectangulo(arg0: &Rectangulo) : u64 {
        arg0.base * arg0.altura
    }

    public fun calcular_area_triangulo(arg0: &Triangulo) : u64 {
        arg0.base * arg0.altura / 2
    }

    // decompiled from Move bytecode v6
}

