module 0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::core_drop {
    public entry fun attach_drop(arg0: &mut 0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::core::Core, arg1: 0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::drop::Drop) {
        0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::core::add_drop<0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::drop::Drop>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

