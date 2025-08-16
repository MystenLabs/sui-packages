module 0xc90bee78f8a30ff70784c27b1b9540413691bcf50b2df7886d7d0715c729ee4e::studentcards1 {
    struct GradeBook has store, key {
        id: 0x2::object::UID,
        yearGrades: 0x2::vec_map::VecMap<u16, StudentCardsList>,
    }

    struct StudentCardsList has drop, store {
        year: u16,
        cards: 0x2::vec_map::VecMap<u64, ReportCard>,
    }

    struct ReportCard has copy, drop, store {
        term: 0x1::string::String,
        courseID: u64,
        courseName: 0x1::string::String,
        midtermGrade: u8,
        finalExam: u8,
        letterGrade: 0x1::string::String,
    }

    public fun add_card(arg0: &mut GradeBook, arg1: u16, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u8, arg6: u8) {
        assert!(0x2::vec_map::contains<u16, StudentCardsList>(&arg0.yearGrades, &arg1), 2);
        assert!(arg5 <= 100 && arg6 <= 100, 5);
        let v0 = 0x2::vec_map::get_mut<u16, StudentCardsList>(&mut arg0.yearGrades, &arg1);
        assert!(!0x2::vec_map::contains<u64, ReportCard>(&v0.cards, &arg3), 3);
        let v1 = ReportCard{
            term         : arg2,
            courseID     : arg3,
            courseName   : arg4,
            midtermGrade : arg5,
            finalExam    : arg6,
            letterGrade  : get_letter_grade(arg5, arg6),
        };
        0x2::vec_map::insert<u64, ReportCard>(&mut v0.cards, arg3, v1);
    }

    public fun create_grade_book(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GradeBook{
            id         : 0x2::object::new(arg0),
            yearGrades : 0x2::vec_map::empty<u16, StudentCardsList>(),
        };
        0x2::transfer::transfer<GradeBook>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun delete_card_list(arg0: &mut GradeBook, arg1: u16) {
        assert!(0x2::vec_map::contains<u16, StudentCardsList>(&arg0.yearGrades, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<u16, StudentCardsList>(&mut arg0.yearGrades, &arg1);
    }

    public fun delete_gradebook(arg0: GradeBook) {
        let GradeBook {
            id         : v0,
            yearGrades : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun get_letter_grade(arg0: u8, arg1: u8) : 0x1::string::String {
        let v0 = (arg0 + arg1) / 2;
        if (v0 >= 90) {
            0x1::string::utf8(b"A")
        } else if (v0 >= 80) {
            0x1::string::utf8(b"B")
        } else if (v0 >= 70) {
            0x1::string::utf8(b"C")
        } else if (v0 >= 60) {
            0x1::string::utf8(b"D")
        } else {
            0x1::string::utf8(b"F")
        }
    }

    public fun get_report_cards(arg0: &GradeBook, arg1: u16) : vector<ReportCard> {
        assert!(0x2::vec_map::contains<u16, StudentCardsList>(&arg0.yearGrades, &arg1), 2);
        let v0 = 0x2::vec_map::get<u16, StudentCardsList>(&arg0.yearGrades, &arg1);
        let v1 = 0x1::vector::empty<ReportCard>();
        let v2 = 0x2::vec_map::keys<u64, ReportCard>(&v0.cards);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = *0x1::vector::borrow<u64>(&v2, v3);
            0x1::vector::push_back<ReportCard>(&mut v1, *0x2::vec_map::get<u64, ReportCard>(&v0.cards, &v4));
            v3 = v3 + 1;
        };
        v1
    }

    public fun get_years(arg0: &GradeBook) : vector<u16> {
        0x2::vec_map::keys<u16, StudentCardsList>(&arg0.yearGrades)
    }

    public fun remove_card(arg0: &mut GradeBook, arg1: u16, arg2: u64) {
        assert!(0x2::vec_map::contains<u16, StudentCardsList>(&arg0.yearGrades, &arg1), 2);
        let v0 = 0x2::vec_map::get_mut<u16, StudentCardsList>(&mut arg0.yearGrades, &arg1);
        assert!(0x2::vec_map::contains<u64, ReportCard>(&v0.cards, &arg2), 4);
        let (_, _) = 0x2::vec_map::remove<u64, ReportCard>(&mut v0.cards, &arg2);
    }

    public fun year_card_list(arg0: &mut GradeBook, arg1: u16) {
        assert!(!0x2::vec_map::contains<u16, StudentCardsList>(&arg0.yearGrades, &arg1), 1);
        let v0 = StudentCardsList{
            year  : arg1,
            cards : 0x2::vec_map::empty<u64, ReportCard>(),
        };
        0x2::vec_map::insert<u16, StudentCardsList>(&mut arg0.yearGrades, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

