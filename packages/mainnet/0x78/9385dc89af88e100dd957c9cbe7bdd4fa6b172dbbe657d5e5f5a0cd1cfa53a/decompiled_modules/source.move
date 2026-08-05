module 0x789385dc89af88e100dd957c9cbe7bdd4fa6b172dbbe657d5e5f5a0cd1cfa53a::source {
    struct PYTH has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_version(arg0: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::Source<PYTH>) {
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::assert_version<PYTH>(arg0, 1);
    }

    public fun create<T0>(arg0: &mut 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::PACKAGE, T0>) : 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::Source<PYTH> {
        let v0 = PYTH{dummy_field: false};
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::create<PYTH, T0>(arg0, arg1, &v0, 1)
    }

    public fun authorize<T0>(arg0: &mut 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::Source<PYTH>, arg1: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::set_authorized<PYTH, T0>(arg0, arg1, arg2, true);
    }

    public fun deauthorize<T0>(arg0: &mut 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::Source<PYTH>, arg1: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::PACKAGE, T0>) {
        assert_version(arg0);
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::set_authorized<PYTH, T0>(arg0, arg1, arg2, false);
    }

    public(friend) fun source_cap(arg0: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::Source<PYTH>) : &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::SourceCap {
        let v0 = PYTH{dummy_field: false};
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source::borrow_source_cap<PYTH>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

